module 0x194c593691aed72b23b967cacad967a93c0b17ff98180d417e91ac503ce3597d::rescuable {
    struct Rescuable has store {
        parent_id: 0x2::object::ID,
        rescuer: address,
    }

    struct RescuerChanged has copy, drop {
        parent_id: 0x2::object::ID,
        new_rescuer: address,
    }

    public fun assert_sender_is_rescuer(arg0: &Rescuable, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rescuer == 0x2::tx_context::sender(arg1), 0);
    }

    public fun destroy(arg0: Rescuable) {
        let Rescuable {
            parent_id : _,
            rescuer   : _,
        } = arg0;
    }

    public fun new(arg0: &0x2::object::UID, arg1: address) : Rescuable {
        Rescuable{
            parent_id : 0x2::object::uid_to_inner(arg0),
            rescuer   : arg1,
        }
    }

    public fun parent_id(arg0: &Rescuable) : 0x2::object::ID {
        arg0.parent_id
    }

    public fun rescue_coin<T0>(arg0: &Rescuable, arg1: &mut 0x2::object::UID, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.parent_id == 0x2::object::uid_to_inner(arg1), 5);
        assert_sender_is_rescuer(arg0, arg5);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(arg1, arg2);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 >= arg4, 3);
        if (v1 == arg4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg4, arg5), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::uid_to_address(arg1));
        };
    }

    public fun rescuer(arg0: &Rescuable) : address {
        arg0.rescuer
    }

    public fun update_rescuer(arg0: &mut Rescuable, arg1: address) {
        assert!(arg1 != @0x0, 4);
        assert!(arg0.rescuer != arg1, 1);
        arg0.rescuer = arg1;
        let v0 = RescuerChanged{
            parent_id   : arg0.parent_id,
            new_rescuer : arg1,
        };
        0x2::event::emit<RescuerChanged>(v0);
    }

    // decompiled from Move bytecode v7
}


module 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::marketplace {
    struct Marketplace has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        receiver: address,
        default_fee: 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::ObjectBox,
    }

    public fun new<T0: store + key>(arg0: address, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : Marketplace {
        Marketplace{
            id          : 0x2::object::new(arg3),
            version     : 1,
            admin       : arg0,
            receiver    : arg1,
            default_fee : 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::new<T0>(arg2, arg3),
        }
    }

    public fun admin(arg0: &Marketplace) : address {
        arg0.admin
    }

    public fun assert_marketplace_admin(arg0: &Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public(friend) fun assert_version(arg0: &Marketplace) {
        assert!(arg0.version == 1, 1000);
    }

    public fun default_fee(arg0: &Marketplace) : &0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::ObjectBox {
        &arg0.default_fee
    }

    public entry fun init_marketplace<T0: store + key>(arg0: address, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Marketplace>(new<T0>(arg0, arg1, arg2, arg3));
    }

    entry fun migrate(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        assert_marketplace_admin(arg0, arg1);
        assert!(arg0.version < 1, 999);
        arg0.version = 1;
    }

    public fun receiver(arg0: &Marketplace) : address {
        arg0.receiver
    }

    // decompiled from Move bytecode v6
}


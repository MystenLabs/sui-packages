module 0x99d04c4474bd22fac5222db1c47a7f3780e74414feb0e631d07af8ae66541d63::big_black_cock {
    struct BigBlackCock has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: BigBlackCock) {
        0x2::kiosk::place<BigBlackCock>(arg0, arg1, arg2);
    }

    public fun change_owner(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address) {
        0x2::kiosk::set_owner_custom(arg0, &arg1, arg2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg1, arg2);
    }

    public fun mint_bbc(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BigBlackCock{
            id  : 0x2::object::new(arg0),
            url : 0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT28m4-9mIOXcsUJsnM0uuNnQCuaOpAnP3wyg&s"),
        };
        0x2::transfer::public_transfer<BigBlackCock>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun takeNtransfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<BigBlackCock>(0x2::kiosk::take<BigBlackCock>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}


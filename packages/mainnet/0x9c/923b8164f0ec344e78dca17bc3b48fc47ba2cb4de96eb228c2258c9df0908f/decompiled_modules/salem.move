module 0x9c923b8164f0ec344e78dca17bc3b48fc47ba2cb4de96eb228c2258c9df0908f::salem {
    struct SALEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALEM>(arg0, 6, b"Salem", b"Salem On Sui", x"4a6f696e20746865202453414c454d206a6f75726e65792c20796f75206e6f74206f6e6c79206f776e20612063727970746f63757272656e63792c2062757420616c736f206265636f6d652070617274206f66207468652053616c656d2066616d696c79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Welcom_2_aef011bf91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALEM>>(v1);
    }

    // decompiled from Move bytecode v6
}


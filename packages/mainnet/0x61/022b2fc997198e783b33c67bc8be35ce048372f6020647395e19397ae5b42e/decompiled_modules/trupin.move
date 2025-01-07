module 0x61022b2fc997198e783b33c67bc8be35ce048372f6020647395e19397ae5b42e::trupin {
    struct TRUPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUPIN>(arg0, 6, b"TruPin", b"TruPin On Sui", x"5768656e205472756d7020616e6420507574696e2064656369646520746f2070756d7020746f6765746865722c206576656e2063727970746f206b6e65656c732120526561647920666f722074686520756c74696d6174652027706f7765722064756f27206d656d65207265766f6c7574696f6e3f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tru_Pin_eb2d408cfc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


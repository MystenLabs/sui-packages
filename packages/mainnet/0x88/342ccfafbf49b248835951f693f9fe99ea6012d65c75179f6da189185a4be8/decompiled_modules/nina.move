module 0x88342ccfafbf49b248835951f693f9fe99ea6012d65c75179f6da189185a4be8::nina {
    struct NINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINA>(arg0, 6, b"NINA", b"SUININA", x"426f726e2066726f6d20746865206c69676874206f662061206e657720737461722c204e696e6120726973657320746f20627269676874656e207468652053554920736b6965732e20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rr_FG_Mu_Af_400x400_d52b101975.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINA>>(v1);
    }

    // decompiled from Move bytecode v6
}


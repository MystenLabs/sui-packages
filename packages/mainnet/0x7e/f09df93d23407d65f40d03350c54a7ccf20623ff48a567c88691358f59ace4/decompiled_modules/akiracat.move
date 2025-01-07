module 0x7ef09df93d23407d65f40d03350c54a7ccf20623ff48a567c88691358f59ace4::akiracat {
    struct AKIRACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIRACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKIRACAT>(arg0, 6, b"AKIRACAT", b"AKIRA CAT ON SUI", b"a Cat with an extraordinary dream to swim in water on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_232054_f61d458bc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIRACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKIRACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1abfb4ccd1ef75932d506c3390370676bedc8ee0e639a7c8ac7f9818ce7db00a::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 8, b"H", b"Humanity Protocol", b"A Human-Centric Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/2d77f36a-8666-422a-bb9f-613381d178b8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<H>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H>>(v1);
    }

    // decompiled from Move bytecode v6
}


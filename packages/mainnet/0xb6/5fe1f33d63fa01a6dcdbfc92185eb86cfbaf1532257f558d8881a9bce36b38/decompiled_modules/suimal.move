module 0xb65fe1f33d63fa01a6dcdbfc92185eb86cfbaf1532257f558d8881a9bce36b38::suimal {
    struct SUIMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAL>(arg0, 9, b"SUIMAL", b"Suimal", b"Suimal is a meme token featuring a unique collection of box-shaped animals! From boxy dogs to cube-shaped cats, each Suimal brings creativity and fun to the digital space. More than just a token, it's a community celebrating quirky art and innovation. Join the Suimal trend and embrace the joy of box-shaped creatures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://statics.solscan.io/cdn/imgs/s60?ref=68747470733a2f2f697066732e696f2f697066732f516d556b34453661756b79556231473469376e7746556b465145446e794d5331475854797170784b4454534d3159")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMAL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


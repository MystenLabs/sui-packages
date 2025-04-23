module 0x1c05a32ab683c55f1940fadba17f4e7024d03ac2f03d61b1f75d69306550784b::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 8, b"GG", b"ertepaF", b"Meme representing A powerful Super~Hero, adorned with the  brilliance only  the F.I.A  protector of many worlds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://shorturl.at/GMlNn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GG>(&mut v2, 4444444444400000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}


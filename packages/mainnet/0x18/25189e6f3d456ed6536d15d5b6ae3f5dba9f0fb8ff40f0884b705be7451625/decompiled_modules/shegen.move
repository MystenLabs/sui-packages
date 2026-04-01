module 0x1825189e6f3d456ed6536d15d5b6ae3f5dba9f0fb8ff40f0884b705be7451625::shegen {
    struct SHEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775027051071-519d846a3d6965836afe23123a385ef2.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775027051071-519d846a3d6965836afe23123a385ef2.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SHEGEN>(arg0, 9, b"SHEGEN", b"Aiwithdaddyissues", b"Shegen Good Coin On Sui", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SHEGEN>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEGEN>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHEGEN>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


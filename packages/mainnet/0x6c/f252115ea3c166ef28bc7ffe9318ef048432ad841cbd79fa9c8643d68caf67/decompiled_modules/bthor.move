module 0x6cf252115ea3c166ef28bc7ffe9318ef048432ad841cbd79fa9c8643d68caf67::bthor {
    struct BTHOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776213539121-b30627c51a24ec8bce0a50213ae03477.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776213539121-b30627c51a24ec8bce0a50213ae03477.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<BTHOR>(arg0, 9, b"BTHOR", b"BITHORCOIN", x"e2808b22424954484f52434f494e20284254484f5229206973206120646563656e7472616c697a6564207574696c69747920746f6b656e2064657369676e656420746f20706f776572206120726f62757374206d756c74692d636861696e2065636f73797374656d2e20466f6375736564206f6e207363616c6162696c69747920616e6420636f6d6d756e6974792d64726976656e206e6f6465732c204254484f522062726964676573206d756c7469706c6520626c6f636b636861696e7320746f20656e737572652073656375726520616e6420656666696369656e74206469676974616c206173736574206d616e6167656d656e742e22", v1, arg1);
        let v4 = v2;
        if (21000000000000000 > 0) {
            0x2::coin::mint_and_transfer<BTHOR>(&mut v4, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTHOR>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTHOR>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x46b1ffbaa362585a702bb1470ffb939a41b7ec4a7b0a8c0cffe2c09eb6c830b6::skyai {
    struct SKYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYAI>(arg0, 9, b"SKYAI", b"SkyAi", b"skyai project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776521389910-2b61df6509a9f8af1e97146eac989e3f.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SKYAI>>(0x2::coin::mint<SKYAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


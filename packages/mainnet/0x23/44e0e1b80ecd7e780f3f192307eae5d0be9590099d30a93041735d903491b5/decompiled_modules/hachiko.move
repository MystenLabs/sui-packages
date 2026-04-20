module 0x2344e0e1b80ecd7e780f3f192307eae5d0be9590099d30a93041735d903491b5::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 9, b"HACHIKO", b"Hachiko Meme Coin", b"Hachiko Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776699588918-3f59117211f1b16a0255d3f8b5b53e69.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HACHIKO>>(0x2::coin::mint<HACHIKO>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


module 0x5b0f14391827155de63e4b43254447434064b687a5e99c57751e0eb8cde6cec1::dude {
    struct DUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDE>(arg0, 9, b"DUDE", b"DUDE is cool", b"Friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=04a4c9224ec9ac04ded2be766d9b01b58f9eee91-6887327-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUDE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUDE>>(v1);
    }

    // decompiled from Move bytecode v6
}


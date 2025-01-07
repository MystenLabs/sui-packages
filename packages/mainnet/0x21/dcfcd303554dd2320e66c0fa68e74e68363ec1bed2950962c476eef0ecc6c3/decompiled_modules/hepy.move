module 0x21dcfcd303554dd2320e66c0fa68e74e68363ec1bed2950962c476eef0ecc6c3::hepy {
    struct HEPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPY>(arg0, 9, b"HEPY", b"HYPE OF YEAR", b"SHEEEESH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=692dd870d354ae3a402296cf7a5d19e111c3f01f-8567894-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEPY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


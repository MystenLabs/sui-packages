module 0x736c555cff4cf91b0fdde7c2e19c91eb000aa1bf264dcc47b59552bbd36d3c0f::bl {
    struct BL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BL>(arg0, 9, b"BL", b"Birds love", b"For Those who love budgie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6b3676f62a8a1b3786049ceddd2ff546blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


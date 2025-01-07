module 0x57bebd89bc74108b0a6adc3482276d1a89d4f3dee58fa64e9f6f7880b5d0eadb::now {
    struct NOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOW>(arg0, 6, b"NOW", b"NOW OR NEVER", b"DON IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippo_4_418392ffb3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOW>>(v1);
    }

    // decompiled from Move bytecode v6
}


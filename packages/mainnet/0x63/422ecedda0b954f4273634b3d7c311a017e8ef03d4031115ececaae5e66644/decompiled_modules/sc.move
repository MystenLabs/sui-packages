module 0x63422ecedda0b954f4273634b3d7c311a017e8ef03d4031115ececaae5e66644::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 9, b"SC", b"Ship Cornor", b"Ship Cornor, my avatar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6f6d6ba7ccdc3d3f85a3b6d716634c24blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


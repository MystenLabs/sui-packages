module 0xc86ea4a359c5299311f8bb6bb3ca1e6f29d5cb130c7d494042cd45409c7b9561::kns {
    struct KNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNS>(arg0, 9, b"KNS", b"7KFUNNAMESERVICE", b"kns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2198e113028d92f896aaff103fb40ccdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


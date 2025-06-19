module 0xc63f262caf4fdf8fccd09c150829c6dffe06aa60326a44afe5accc04fcc31417::lcc {
    struct LCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCC>(arg0, 9, b"LCC", b"launchcoin", b"best coin for best life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/47c524bb3eb5e7d1b5f4dca0efafe877blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xa21b79f5222c3873307820e53d90f850eb22be5ad5cd978f3097b2f60183de87::duckibox {
    struct DUCKIBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKIBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKIBOX>(arg0, 9, b"DICKI", b"duckibox", b"duck black box", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/1708bc34-2de8-44b5-ba12-f46d11398db2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKIBOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKIBOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x2ab1151346df78c87bc798614a59e47ef02e4504841c083c8c7f25bfde414220::token3 {
    struct TOKEN3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN3>(arg0, 9, b"t3", b"token3", b"evil ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/d6ffc010-2139-498b-9f16-7aed04b58746.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


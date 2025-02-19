module 0x7bcf4b281a61b542d53b233d01894a673dcf9d8d96610ccc335904f9dd4dd9cb::pwug {
    struct PWUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWUG>(arg0, 9, b"PWUG", b"Pwug on Sui", b"With PWUG it's all about fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWYMpEuy9V1q2jXkD1RMVNsf24GpFLBb6M7VhQ4k8amnP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PWUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWUG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


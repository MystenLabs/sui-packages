module 0x8e4443e70f49d23ef8e30ceb3774b638e831091129052c6508c345d9f98acfe5::sendy {
    struct SENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDY>(arg0, 6, b"SENDY", b"SENDY SUI", x"444f472042590a0a4d4154542046555249450a0a53454e4459202d20696e7370697265642062792061206261736564204d617474204675726965206368617261637465722063616d6520746f20636f6e7175657220446f67204d657461206f6e2073756920636861696e2e20546865206e6578742062616e67657220746f207468652027426f797320436c756227", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_05_15_9617e689b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xe3825549c9f99b0956e01e97223038e18145afe5a8c39ec4a97c7b02836e63ab::munki {
    struct MUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNKI>(arg0, 6, b"MUNKI", b"MUNKIDORI", b"Good for entry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwq7i35wd3y4hlefahzwo66l4ne54k744uea5pwdzno7ew3bbmmy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUNKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


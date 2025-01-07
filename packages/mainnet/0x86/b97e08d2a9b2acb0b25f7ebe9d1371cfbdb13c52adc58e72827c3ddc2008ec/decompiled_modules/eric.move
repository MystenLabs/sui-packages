module 0x86b97e08d2a9b2acb0b25f7ebe9d1371cfbdb13c52adc58e72827c3ddc2008ec::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 9, b"ERIC", b"Flat Eric", b"Flat Eric is a Muppet character created by Quentin Dupieux (Mr. Oizo) and built by Jim Henson's Creature Shop (famous for The Muppets) reimagined on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreic72pqwwgyurjzyl42pjpa5qef77nyopnk2habmpxovigbyhzrzmy.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


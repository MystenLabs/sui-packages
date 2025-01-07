module 0x565b97e2520990348f1827148e86fcfc842b4db313b049b1e87f1eba5ba4bb04::dober {
    struct DOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBER>(arg0, 9, b"DOBER", b"Doberman", b"Tw: Soon,Web: Soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://doberman-newa.vercel.app/images/dog2-removebg-preview.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOBER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}


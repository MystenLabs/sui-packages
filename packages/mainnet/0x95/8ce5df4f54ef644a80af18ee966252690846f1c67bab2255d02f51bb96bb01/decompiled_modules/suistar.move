module 0x958ce5df4f54ef644a80af18ee966252690846f1c67bab2255d02f51bb96bb01::suistar {
    struct SUISTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTAR>(arg0, 9, b"SUISTAR", b"Sui Star", b"Sea Star is Meme on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843774875712016385/Q0olVMTI.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISTAR>(&mut v2, 350000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


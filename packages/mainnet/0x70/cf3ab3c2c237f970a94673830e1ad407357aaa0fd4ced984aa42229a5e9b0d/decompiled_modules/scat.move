module 0x70cf3ab3c2c237f970a94673830e1ad407357aaa0fd4ced984aa42229a5e9b0d::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 9, b"SCAT", b"Selfie Cat", b"Meow take a selfie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcrXmNmbpwi89a9LxWsa1n3Khnu1M9DQb89GCbM5FHYqH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


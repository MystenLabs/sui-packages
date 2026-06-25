module 0x10b6174c11686989cbc9857cdbb8ec667ca3d9795e08280135e6011ca02ed3cd::motolove {
    struct MOTOLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTOLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTOLOVE>(arg0, 9, b"MTL", b"MotoLove", b"Community token for motorcycle lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigl6vfrmx6sqsqa24ly24dhv7hpupubhrdw77jtktbslvcq7eyggy")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOTOLOVE>>(0x2::coin::mint<MOTOLOVE>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTOLOVE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOTOLOVE>>(v2);
    }

    // decompiled from Move bytecode v7
}


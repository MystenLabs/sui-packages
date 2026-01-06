module 0x356a28b8bbb6ae4994c583f34d55f7fcbb131b0dc097292b7df50080e9112350::mrbeast {
    struct MRBEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBEAST>(arg0, 9, b"MR BEAST", b"Mr Beast", b"https://x.com/MrBeast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ4376uqoPfjJ2CVSqoxFsZXEHcixrbJotevNCwgaKYVD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRBEAST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBEAST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRBEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x43532bf8a59717f1f77d2dfabc23318961e6878c48096c57d78598db3b6bc38f::mgl {
    struct MGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGL>(arg0, 5, b"MGL", b"Megalodon", b"Megalodon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img1.pnghut.com/t/13/21/4/Y030rvpdTi/fish-megamouth-shark-fictional-character-vertebrate-blue.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MGL>(&mut v2, 4700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGL>>(v1);
    }

    // decompiled from Move bytecode v6
}


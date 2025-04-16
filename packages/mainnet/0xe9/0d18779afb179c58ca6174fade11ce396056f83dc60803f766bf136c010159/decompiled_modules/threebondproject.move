module 0xe90d18779afb179c58ca6174fade11ce396056f83dc60803f766bf136c010159::threebondproject {
    struct THREEBONDPROJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THREEBONDPROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THREEBONDPROJECT>(arg0, 6, b"THREEBONDPROJECT", b"MOONBARAK REBELZ SUI WOLF PACK", b"THE FIRST 3 BONDED PROJECT HAVE SUPPORTED FROM MOONBAGS TEAM WITH 3000 SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibhe5uue6ynn652xwhounwvnijl4lddye5h6c67ymgxy7fcygqiyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THREEBONDPROJECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THREEBONDPROJECT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


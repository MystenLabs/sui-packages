module 0xfd11518280173d8ffc31ba43fb4abebf2576a2112593da0ffc1bcdca8a74aa6c::memeark {
    struct MEMEARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEARK>(arg0, 6, b"MEMEARK", b"MemeArk", b"If you cant chose one, then choose all of them! Super Memecoin Cycle is here and we need to pick the right one. Monkeys, dogs, cats, snakes, bulls, bears, dolphins, hippos, wolfs, frogs, coqs and much more inside of this beautiful MemeArk! THE ONLY COIN YOU NEED TO HAVE THEM ALL inspired by the Noahs Ark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmanww_Z_Pgh_R4xnz87eo56jqmgq_Zn_W6xwt6_R_Rign_T_Fi_K_Xuq_e6b3def4fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEARK>>(v1);
    }

    // decompiled from Move bytecode v6
}


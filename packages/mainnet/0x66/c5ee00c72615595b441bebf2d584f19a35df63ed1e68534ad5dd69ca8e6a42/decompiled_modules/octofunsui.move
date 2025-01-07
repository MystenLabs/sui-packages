module 0x66c5ee00c72615595b441bebf2d584f19a35df63ed1e68534ad5dd69ca8e6a42::octofunsui {
    struct OCTOFUNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOFUNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOFUNSUI>(arg0, 6, b"OctofunSui", b"Octofun", b"Octopass is coming to Sui market - A meme token acting like a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L1_PF_Ot_Vg_400x400_a47804e3b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOFUNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOFUNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


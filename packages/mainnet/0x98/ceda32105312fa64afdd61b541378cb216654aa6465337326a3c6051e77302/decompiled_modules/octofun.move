module 0x98ceda32105312fa64afdd61b541378cb216654aa6465337326a3c6051e77302::octofun {
    struct OCTOFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOFUN>(arg0, 6, b"OCTOFUN", b"OctopusFun", b"Ready to dive deep into the potential of the SUI memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L1_PF_Ot_Vg_400x400_1bd4a6781d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}


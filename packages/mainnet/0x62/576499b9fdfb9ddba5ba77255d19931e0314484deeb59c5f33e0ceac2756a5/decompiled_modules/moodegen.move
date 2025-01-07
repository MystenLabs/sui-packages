module 0x62576499b9fdfb9ddba5ba77255d19931e0314484deeb59c5f33e0ceac2756a5::moodegen {
    struct MOODEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODEGEN>(arg0, 6, b"MooDegen", b"Dengy, AKA MooDegen", b"Meet MooDeng's big bro: Dengy, AKA MooDegen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_S_Wu_Khr_400x400_e771945047.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


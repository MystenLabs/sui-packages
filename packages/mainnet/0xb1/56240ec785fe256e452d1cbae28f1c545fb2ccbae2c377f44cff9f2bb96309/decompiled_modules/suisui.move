module 0xb156240ec785fe256e452d1cbae28f1c545fb2ccbae2c377f44cff9f2bb96309::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 6, b"SUISUI", b"Suisui the Cat", b"Suisui the Cat is a clever and adventurous feline, always one step ahead. With sharp instincts and a playful personality, Suisui glides through life with grace and a hint of mystery. Whether navigating through tight spots or pulling off clever tricks, this cat is full of surprises. Suisui invites everyone to join in its unpredictable and exciting adventures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sem_t_A_tulo_7f826fb894.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


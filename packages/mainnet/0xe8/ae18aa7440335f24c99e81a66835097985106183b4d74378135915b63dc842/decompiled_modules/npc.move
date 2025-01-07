module 0xe8ae18aa7440335f24c99e81a66835097985106183b4d74378135915b63dc842::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPC>(arg0, 6, b"NPC", b"Non-Player Character", b"NPC is an abbreviation of Non-Player Character which means a character in a  Token  that is controlled by a community, not by the dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_50_44cc2257ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPC>>(v1);
    }

    // decompiled from Move bytecode v6
}


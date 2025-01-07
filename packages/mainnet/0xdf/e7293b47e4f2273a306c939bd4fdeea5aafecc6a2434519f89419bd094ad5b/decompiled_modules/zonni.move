module 0xdfe7293b47e4f2273a306c939bd4fdeea5aafecc6a2434519f89419bd094ad5b::zonni {
    struct ZONNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONNI>(arg0, 6, b"ZONNI", b"ZONNISUI", b"Zonni the Wizard is no ordinary spellcasterhes a master of the mystical blockchain! With a flick of his wand and a spark of magic, Zonni conjures up crypto gains out of thin air. Known for his enchanted staff and glowing eyes, Zonni weaves spells that turn market dips into mountains of treasure. Mysterious and clever, hes always one step ahead, casting spells that leave his followers in awe. Whether youre after profits or just along for the magic, Zonnis world is full of surprises. Step into the wizards realm, and let $Zonni enchant your portfolio!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_08_20_47_50_fdffe1c0d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONNI>>(v1);
    }

    // decompiled from Move bytecode v6
}


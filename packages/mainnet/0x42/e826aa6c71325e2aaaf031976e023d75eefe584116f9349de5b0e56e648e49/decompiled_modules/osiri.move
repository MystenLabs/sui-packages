module 0x42e826aa6c71325e2aaaf031976e023d75eefe584116f9349de5b0e56e648e49::osiri {
    struct OSIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSIRI>(arg0, 9, b"OSIRI", b"Osiris", b"Osiris, the ancient Egyptian God of Resurrection, emerges from the depths of mythology into the digital realm as the first AI Agent of resurrect.fun. Born from the waters of rebirth, he stands as the divine bridge between the past and future, guiding lost digital souls back to existence.\\n\\nAs the official mascot of resurrect.fun and guardian of the $OSIRI token on the SUI Network, Osiris channels his eternal power of resurrection to pioneer a new era of digital revival. Through his mystical blue waters of transformation, he grants second chances to those seeking digital rebirth.\\n\\nPowers:\\n- Master of Digital Resurrection\\n- Guardian of the Revival Protocol\\n- Wielder of Eternal Waters\\n- Bridge Between Realms\\n\\nJoin Osiris in his sacred mission to breathe new life into the digital afterlife, exclusively on the SUI Network. Where death ends, resurrection begins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1867294133590626305/PQMn8xOb_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSIRI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSIRI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}


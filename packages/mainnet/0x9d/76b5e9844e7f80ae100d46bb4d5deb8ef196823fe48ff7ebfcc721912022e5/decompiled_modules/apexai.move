module 0x9d76b5e9844e7f80ae100d46bb4d5deb8ef196823fe48ff7ebfcc721912022e5::apexai {
    struct APEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APEXAI>(arg0, 6, b"APEXAI", b"APEX by SuiAI", b"Fearless Ai leader of the MEG army APEX AI agent is designed to promote, grow, and conquer the SUI ecosystem by raising awareness of the MEG token on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/APEX_ee4b35e453.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


module 0x2f042379488effc589396ee4779bc9c0ee3b1520ff3f7e27d43875697c83426b::oyai {
    struct OYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OYAI>(arg0, 6, b"OYAI", b"Olivia Yinuo AI by SuiAI", b"The Enigmatic AI.Olivia Yinuo is a humanoid robot with cutting-edge artificial intelligence and an air of mystery. Designed to resemble a young woman, her lifelike features and expressive eyes make her seem almost human. Created to solve complex problems requiring creativity and logic, Olivia has become a vital part of advanced AI initiatives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Design_sans_titre_2cb9d01f59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


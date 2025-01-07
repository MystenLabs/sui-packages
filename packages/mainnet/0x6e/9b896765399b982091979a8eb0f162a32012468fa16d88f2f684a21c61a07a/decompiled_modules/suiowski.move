module 0x6e9b896765399b982091979a8eb0f162a32012468fa16d88f2f684a21c61a07a::suiowski {
    struct SUIOWSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOWSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOWSKI>(arg0, 6, b"Suiowski", b"Suiowski - The Monster of Sui", b"The first Monster - Suiowski on the blockchain Sui. Brrr!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_blue_3_Drendered_Mike_Wazowski_the_o_2_76e477408c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOWSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOWSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}


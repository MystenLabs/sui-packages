module 0x697e488b9a568f6bde4e93a3cded506fcd5afc030a382e88572a2af23f5277f7::gyara {
    struct GYARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYARA>(arg0, 6, b"GYARA", b"Gyarados", b"$GYARA forged in rage, unleashed on-chain. 100% fury. 0% chill. Powered by blind aggression and questionable decisions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicb2f3wboatehghup5szmkwru6dgaiorevwq7xkzm3trorqoby7rm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GYARA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


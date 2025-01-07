module 0x2162a54a1a7fdc433e37b7b7ad5e63436cee6fb473e21691978e79b307c180fc::aquabrett {
    struct AQUABRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUABRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUABRETT>(arg0, 6, b"AQUABRETT", b"Aquabrett", b"Aquabrett - The hero of the Sui blockchain, rising from the depths to defend the crypto seas. Join TG and aid us in this fight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_de37a36f9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUABRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUABRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}


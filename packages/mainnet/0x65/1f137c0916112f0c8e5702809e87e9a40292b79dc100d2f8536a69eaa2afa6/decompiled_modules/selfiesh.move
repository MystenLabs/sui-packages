module 0x651f137c0916112f0c8e5702809e87e9a40292b79dc100d2f8536a69eaa2afa6::selfiesh {
    struct SELFIESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIESH>(arg0, 6, b"SELFIESH", b"Selfiesh", b"Get ready to dive into the most selfie-tastic waters of the blockchain! Our selfie-obsessed fish is always prepared to snap the perfect shot, with a selfie stick in one fin and a whole lot of attitude in the other! With $SELFIESH, youll ride the memecoin wave and capture epic moments while conquering the seas of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sem_t_A_tulo_12_461b79ef16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIESH>>(v1);
    }

    // decompiled from Move bytecode v6
}


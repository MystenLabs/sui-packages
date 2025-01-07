module 0x3accae203293fb4dc5beca1c7caccfe0390380df205a945c12ffe0760ee9f637::sab {
    struct SAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAB>(arg0, 6, b"Sab", b"Santa Brothers", b"Santa Brothers Memes brings festive cheer and crypto vibes together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23_3be245bcb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAB>>(v1);
    }

    // decompiled from Move bytecode v6
}


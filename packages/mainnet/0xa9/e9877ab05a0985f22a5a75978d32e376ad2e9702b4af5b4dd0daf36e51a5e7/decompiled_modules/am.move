module 0xa9e9877ab05a0985f22a5a75978d32e376ad2e9702b4af5b4dd0daf36e51a5e7::am {
    struct AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM>(arg0, 6, b"AM", b"Argu Mint", x"61207261796469756d20706f6f6c2077696c6c2062652073656564656420696e20746865206e65787420352d3230206d696e757465732077697468202431362c333632206f66206c69717569646974792e0a746865206c696e6b2077696c6c206265207368617265642068657265207768656e2072656164792c206f6e6c7920747275737420746865206c696e6b20706f737465642068657265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_703a438432.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AM>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xec25be82faf6a4b5293c78a19a54097a678e5b63c923c4081a90cfb89f166c4b::thelifeofcat {
    struct THELIFEOFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THELIFEOFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THELIFEOFCAT>(arg0, 6, b"TheLifeOfCat", b"the life of cat", x"746865206c696665206f66206361742028636174290a49276d206120676f6f64206b697474792074696c6c2049276d206e6f742e20416e6420796f7520646f6e27742077616e7420746f2073656520746861742073696465206f66206d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5345_50ccc5ab79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THELIFEOFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THELIFEOFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


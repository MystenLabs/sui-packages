module 0x406ff378c408c78082bcb3b321a45ba154265464c7047bf42b9cb9d4e5dc603e::shi {
    struct SHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHI>(arg0, 9, b"SHI", b"sushi", x"4920746f6c64206d792073757368692069742077617320746f6f20726177e280a6206e6f77206974e280997320696e20746865726170792ee2809d0a0ae2809c53757368693a20746865206f6e6c79207468696e6720746861742063616e206d616b6520796f75206665656c2066756c6c20616e6420656d707479206174207468652073616d652074696d652ee2809d0a0ae2809c5768656e20796f757220737573686920706c6174746572206c6f6f6b7320626574746572207468616e20796f7572206c6966652063686f69636573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7993933b95a17c3c6fdb803910cb9bccblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


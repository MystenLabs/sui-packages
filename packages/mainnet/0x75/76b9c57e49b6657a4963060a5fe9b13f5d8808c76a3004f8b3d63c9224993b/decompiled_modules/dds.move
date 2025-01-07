module 0x7576b9c57e49b6657a4963060a5fe9b13f5d8808c76a3004f8b3d63c9224993b::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDS>(arg0, 9, b"DDS", b"DukDukSui", x"5468652073696d706c6963697479206f662063757465e280a62044756b20746865206475636b6c696e6720697320656e6a6f79696e67206c69666521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d18bef21f5cd6ae415404f1b8e9354d9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


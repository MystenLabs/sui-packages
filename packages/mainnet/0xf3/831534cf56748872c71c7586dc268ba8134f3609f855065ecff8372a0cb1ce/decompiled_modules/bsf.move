module 0xf3831534cf56748872c71c7586dc268ba8134f3609f855065ecff8372a0cb1ce::bsf {
    struct BSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSF>(arg0, 9, b"BSF", b"Boy SUI Family", b"The boy holding the guitar is an inspiring image, symbolizing his passion for music and his desire to reach far. With the guitar in his hand, he passionately glided his fingers over each string, creating melodious melodies, when quiet, when vibrant. Whether standing on stage or simply sitting on the corner, the boy always burns with music, turning each note into his own story. That image not only shows talent but also evokes perseverance, enthusiasm and boundless love for art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e3dcfdd62fd08f8541c3da2ac82ea685blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


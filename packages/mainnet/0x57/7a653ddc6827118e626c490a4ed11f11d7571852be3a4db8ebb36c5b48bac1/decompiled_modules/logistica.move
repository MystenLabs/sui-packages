module 0x577a653ddc6827118e626c490a4ed11f11d7571852be3a4db8ebb36c5b48bac1::logistica {
    struct SelloCriptografico has copy, drop {
        huella_sha256: 0x1::string::String,
        timestamp_sui: u64,
    }

    public entry fun sellar_transaccion(arg0: 0x1::string::String, arg1: u64) {
        let v0 = SelloCriptografico{
            huella_sha256 : arg0,
            timestamp_sui : arg1,
        };
        0x2::event::emit<SelloCriptografico>(v0);
    }

    // decompiled from Move bytecode v7
}


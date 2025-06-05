module 0xe93daa77b42e9edcfbc8627ab2078e019ec27a20a9dd661de294ef961524e952::weather {
    struct WeatherNFT has store, key {
        id: 0x2::object::UID,
        location: 0x1::string::String,
        temperature: u64,
        timestamp_ms: u64,
    }

    struct WeatherResponse has copy, drop {
        location: 0x1::string::String,
        temperature: u64,
    }

    struct WEATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8e4bd0d16c2153c7761f950ac629ef83349607906aa7609b636f18ea900156e::enclave::new_cap<WEATHER>(arg0, arg1);
        0xa8e4bd0d16c2153c7761f950ac629ef83349607906aa7609b636f18ea900156e::enclave::create_enclave_config<WEATHER>(&v0, 0x1::string::utf8(b"weather enclave"), x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", arg1);
        0x2::transfer::public_transfer<0xa8e4bd0d16c2153c7761f950ac629ef83349607906aa7609b636f18ea900156e::enclave::Cap<WEATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun update_weather<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &vector<u8>, arg4: &0xa8e4bd0d16c2153c7761f950ac629ef83349607906aa7609b636f18ea900156e::enclave::Enclave<T0>, arg5: &mut 0x2::tx_context::TxContext) : WeatherNFT {
        let v0 = WeatherResponse{
            location    : arg0,
            temperature : arg1,
        };
        assert!(0xa8e4bd0d16c2153c7761f950ac629ef83349607906aa7609b636f18ea900156e::enclave::verify_signature<T0, WeatherResponse>(arg4, 0, arg2, v0, arg3), 1);
        WeatherNFT{
            id           : 0x2::object::new(arg5),
            location     : arg0,
            temperature  : arg1,
            timestamp_ms : arg2,
        }
    }

    // decompiled from Move bytecode v6
}


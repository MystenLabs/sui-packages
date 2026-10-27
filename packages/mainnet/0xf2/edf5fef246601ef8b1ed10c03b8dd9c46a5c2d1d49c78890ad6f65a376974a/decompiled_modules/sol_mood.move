module 0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::sol_mood {
    struct SOL_MOOD has drop {
        dummy_field: bool,
    }

    struct SolMoodWitness has store, key {
        id: 0x2::object::UID,
    }

    struct SolMood has key {
        id: 0x2::object::UID,
        witness_id: 0x2::object::ID,
        witness: 0x2::bag::Bag,
        face: 0x1::string::String,
        emoji: 0x1::string::String,
        label: 0x1::string::String,
        price: 0x1::string::String,
        price_scaled: u64,
        updated_ms: u64,
        readings: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : SolMood {
        let v0 = SolMoodWitness{id: 0x2::object::new(arg0)};
        let v1 = 0x2::bag::new(arg0);
        0x2::bag::add<vector<u8>, SolMoodWitness>(&mut v1, b"witness", v0);
        let v2 = 0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::neutral();
        SolMood{
            id           : 0x2::object::new(arg0),
            witness_id   : 0x2::object::id<SolMoodWitness>(&v0),
            witness      : v1,
            face         : 0x1::string::utf8(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::codepoint(v2)),
            emoji        : 0x1::string::utf8(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::emoji(v2)),
            label        : 0x1::string::utf8(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::label(v2)),
            price        : 0x1::string::utf8(b"-"),
            price_scaled : 0,
            updated_ms   : 0,
            readings     : 0,
        }
    }

    fun input_commitment(arg0: &SolMood, arg1: &0x2::clock::Clock, arg2: &0x1::string::String) : vector<u8> {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(0x2::object::id<SolMood>(arg0));
        let v1 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(0x2::object::id<0x2::clock::Clock>(arg1));
        let v2 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(json_string(*0x1::string::as_bytes(arg2)));
        let v3 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v4, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v0));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v4, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v1));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v4, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v2));
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::input_hash(vector[b"0", b"1", b"2"], v3)
    }

    public fun label(arg0: &SolMood) : 0x1::string::String {
        arg0.label
    }

    fun assert_workflow_invocation(arg0: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult) {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::proof(arg0);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::type_name(v0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>()), 13906834934552592385);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(v0) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::execution_id(arg1), 13906834943142658051);
        assert!(!0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::is_finalized(arg1), 13906834947437756421);
    }

    fun err(arg0: vector<u8>) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"err"), b"reason", text(arg0))
    }

    public fun execute(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg2: &mut SolMood, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_workflow_invocation(&arg0, &arg1);
        assert!(input_commitment(arg2, arg3, &arg4) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::input_commitment(&arg1), 13906834831473770503);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::satisfy(&mut arg0, &witness(arg2).id);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::parse_price(0x1::string::as_bytes(&arg4));
        let v2 = if (v1 == 0) {
            err(b"price is not an unsigned decimal")
        } else if (!0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::accepts(arg2.price_scaled, arg2.updated_ms, v0, v1)) {
            err(b"price moved more than 20% since the last reading")
        } else {
            record(arg2, arg4, v1, v0)
        };
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::finalize_and_share(arg1, arg0, v2, arg5);
    }

    public fun face(arg0: &SolMood) : 0x1::string::String {
        arg0.face
    }

    fun init(arg0: SOL_MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SOL_MOOD>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{emoji} SOL Mood: {label}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Latest SOL price: {price} USD. Updated by a Nexus agent from Coinbase data."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://cdn.jsdelivr.net/gh/jdecked/twemoji@16.0.1/assets/72x72/{face}.png"));
        let v5 = 0x2::display::new_with_fields<SolMood>(&v0, v1, v3, arg1);
        0x2::display::update_version<SolMood>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SolMood>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<SolMood>(new(arg1));
    }

    fun json_string(arg0: vector<u8>) : vector<u8> {
        let v0 = b"\"";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, 34);
        v0
    }

    fun number(arg0: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg0)))
    }

    public fun price(arg0: &SolMood) : 0x1::string::String {
        arg0.price
    }

    public fun price_scaled(arg0: &SolMood) : u64 {
        arg0.price_scaled
    }

    public fun readings(arg0: &SolMood) : u64 {
        arg0.readings
    }

    fun record(arg0: &mut SolMood, arg1: 0x1::string::String, arg2: u64, arg3: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput {
        let (v0, v1) = if (arg0.price_scaled == 0) {
            (false, 0)
        } else {
            0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::change_bps(arg0.price_scaled, arg2)
        };
        let v2 = 0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::level(v0, v1);
        let v3 = if (v1 == 0) {
            b"flat"
        } else if (v0) {
            b"up"
        } else {
            b"down"
        };
        arg0.face = 0x1::string::utf8(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::codepoint(v2));
        arg0.emoji = 0x1::string::utf8(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::emoji(v2));
        arg0.label = 0x1::string::utf8(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::label(v2));
        arg0.price = arg1;
        arg0.price_scaled = arg2;
        arg0.updated_ms = arg3;
        arg0.readings = arg0.readings + 1;
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"ok"), b"change_bps", number(v1)), b"direction", text(v3)), b"emoji", text(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::emoji(v2))), b"face", text(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::codepoint(v2))), b"label", text(0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood::label(v2))), b"price", text(*0x1::string::as_bytes(&arg0.price)))
    }

    fun text(arg0: vector<u8>) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(json_string(arg0))
    }

    public fun tool_witness_id(arg0: &SolMood) : 0x2::object::ID {
        arg0.witness_id
    }

    public fun updated_ms(arg0: &SolMood) : u64 {
        arg0.updated_ms
    }

    fun witness(arg0: &SolMood) : &SolMoodWitness {
        0x2::bag::borrow<vector<u8>, SolMoodWitness>(&arg0.witness, b"witness")
    }

    // decompiled from Move bytecode v7
}


module 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::support_config {
    struct SupportConfig has store {
        supported_curves_to_signature_algorithms_to_hash_schemes: 0x2::vec_map::VecMap<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>,
        paused_curves: vector<u32>,
        paused_signature_algorithms: vector<u32>,
        paused_hash_schemes: vector<u32>,
        signature_algorithms_allowed_global_presign: vector<u32>,
    }

    struct GlobalPresignConfig has store {
        curve_to_signature_algorithms_for_dkg: 0x2::vec_map::VecMap<u32, vector<u32>>,
        curve_to_signature_algorithms_for_imported_key: 0x2::vec_map::VecMap<u32, vector<u32>>,
    }

    public(friend) fun create(arg0: 0x2::vec_map::VecMap<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>) : SupportConfig {
        SupportConfig{
            supported_curves_to_signature_algorithms_to_hash_schemes : arg0,
            paused_curves                                            : vector[],
            paused_signature_algorithms                              : vector[],
            paused_hash_schemes                                      : vector[],
            signature_algorithms_allowed_global_presign              : vector[],
        }
    }

    public(friend) fun create_global_presign_config(arg0: 0x2::vec_map::VecMap<u32, vector<u32>>, arg1: 0x2::vec_map::VecMap<u32, vector<u32>>) : GlobalPresignConfig {
        GlobalPresignConfig{
            curve_to_signature_algorithms_for_dkg          : arg0,
            curve_to_signature_algorithms_for_imported_key : arg1,
        }
    }

    public(friend) fun is_global_presign_for_dkg(arg0: &GlobalPresignConfig, arg1: u32, arg2: u32) : bool {
        0x2::vec_map::contains<u32, vector<u32>>(&arg0.curve_to_signature_algorithms_for_dkg, &arg1) && 0x1::vector::contains<u32>(0x2::vec_map::get<u32, vector<u32>>(&arg0.curve_to_signature_algorithms_for_dkg, &arg1), &arg2)
    }

    public(friend) fun is_global_presign_for_imported_key(arg0: &GlobalPresignConfig, arg1: u32, arg2: u32) : bool {
        0x2::vec_map::contains<u32, vector<u32>>(&arg0.curve_to_signature_algorithms_for_imported_key, &arg1) && 0x1::vector::contains<u32>(0x2::vec_map::get<u32, vector<u32>>(&arg0.curve_to_signature_algorithms_for_imported_key, &arg1), &arg2)
    }

    public(friend) fun set_global_presign_config(arg0: &mut GlobalPresignConfig, arg1: 0x2::vec_map::VecMap<u32, vector<u32>>, arg2: 0x2::vec_map::VecMap<u32, vector<u32>>) {
        arg0.curve_to_signature_algorithms_for_dkg = arg1;
        arg0.curve_to_signature_algorithms_for_imported_key = arg2;
    }

    public(friend) fun set_paused(arg0: &mut SupportConfig, arg1: vector<u32>, arg2: vector<u32>, arg3: vector<u32>) {
        arg0.paused_curves = arg1;
        arg0.paused_signature_algorithms = arg2;
        arg0.paused_hash_schemes = arg3;
    }

    public(friend) fun set_supported_curves_to_signature_algorithms_to_hash_schemes(arg0: &mut SupportConfig, arg1: 0x2::vec_map::VecMap<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>) {
        arg0.supported_curves_to_signature_algorithms_to_hash_schemes = arg1;
    }

    public(friend) fun validate_curve(arg0: &SupportConfig, arg1: u32) {
        assert!(0x2::vec_map::contains<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>(&arg0.supported_curves_to_signature_algorithms_to_hash_schemes, &arg1), 2);
        assert!(!0x1::vector::contains<u32>(&arg0.paused_curves, &arg1), 4);
    }

    public(friend) fun validate_curve_and_signature_algorithm(arg0: &SupportConfig, arg1: u32, arg2: u32) {
        validate_curve(arg0, arg1);
        let v0 = *0x2::vec_map::get<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>(&arg0.supported_curves_to_signature_algorithms_to_hash_schemes, &arg1);
        assert!(0x2::vec_map::contains<u32, vector<u32>>(&v0, &arg2), 3);
        assert!(!0x1::vector::contains<u32>(&arg0.paused_signature_algorithms, &arg2), 5);
    }

    public(friend) fun validate_curve_and_signature_algorithm_and_hash_scheme(arg0: &SupportConfig, arg1: u32, arg2: u32, arg3: u32) {
        validate_curve_and_signature_algorithm(arg0, arg1, arg2);
        let v0 = *0x2::vec_map::get<u32, vector<u32>>(0x2::vec_map::get<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>(&arg0.supported_curves_to_signature_algorithms_to_hash_schemes, &arg1), &arg2);
        assert!(0x1::vector::contains<u32>(&v0, &arg3), 1);
        assert!(!0x1::vector::contains<u32>(&arg0.paused_hash_schemes, &arg3), 6);
    }

    // decompiled from Move bytecode v6
}


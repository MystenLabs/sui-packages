module 0x772ac8a6699e8152a50b6bb3276c0b4a66566cbb2cb0a794e90415f2c32f3ab6::skill_descriptor {
    struct SkillDescriptor has store, key {
        id: 0x2::object::UID,
        skill_id: vector<u8>,
        walrus_manifest_blob: vector<u8>,
        manifest_hash: vector<u8>,
        mvr_package_name: vector<u8>,
        version: vector<u8>,
        required_capabilities: vector<vector<u8>>,
        dependencies: vector<vector<u8>>,
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : SkillDescriptor {
        SkillDescriptor{
            id                    : 0x2::object::new(arg5),
            skill_id              : arg0,
            walrus_manifest_blob  : arg1,
            manifest_hash         : arg2,
            mvr_package_name      : arg3,
            version               : arg4,
            required_capabilities : vector[],
            dependencies          : vector[],
        }
    }

    // decompiled from Move bytecode v7
}


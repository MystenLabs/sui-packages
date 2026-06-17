module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::lineage {
    struct ProvenanceManifest has copy, drop, store {
        root_id: 0x2::object::ID,
        ancestor_ids: vector<0x2::object::ID>,
        depth: u64,
    }

    public fun build_manifest(arg0: &0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::WorkObject, arg1: vector<0x2::object::ID>, arg2: u64) : ProvenanceManifest {
        ProvenanceManifest{
            root_id      : 0x2::object::id<0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::WorkObject>(arg0),
            ancestor_ids : arg1,
            depth        : arg2,
        }
    }

    public fun direct_parents(arg0: &0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::WorkObject) : vector<0x2::object::ID> {
        *0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::parents(arg0)
    }

    public fun manifest_ancestors(arg0: &ProvenanceManifest) : &vector<0x2::object::ID> {
        &arg0.ancestor_ids
    }

    public fun manifest_depth(arg0: &ProvenanceManifest) : u64 {
        arg0.depth
    }

    public fun manifest_root(arg0: &ProvenanceManifest) : 0x2::object::ID {
        arg0.root_id
    }

    // decompiled from Move bytecode v7
}

